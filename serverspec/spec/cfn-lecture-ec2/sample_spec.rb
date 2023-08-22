require 'spec_helper'

listen_port = 8080

describe package('nginx') do
  it { should be_installed }
end

# （追加テスト）Nginxが起動していることを確認
describe service('nginx') do
  it { should be_running }
end

# （追加テスト）Nginxの設定ファイルが存在することを確認
describe file('/etc/nginx/conf.d/localhost.conf') do
  it { should be_file }
end

describe port(listen_port) do
  it { should be_listening }
end

describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end
