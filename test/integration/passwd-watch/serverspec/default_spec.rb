require 'spec_helper'

describe file('/etc/audit') do
  it { should be_directory }
end

%W(
  /etc/audit/auditd.conf
  /etc/audit/audit.rules
).each do |f|
  describe file(f) do
    it { should be_file }
  end
end

describe package("auditd") do
  it { should be_installed }
end

describe service('auditd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/audit/audit.rules') do
  its(:content) { should match /passwd_changes/ }
end

describe file('/var/log/audit/audit.log') do
  its(:content) { should match %r"/etc/passwd.*nametype=CREATE" }
end
