require 'spec_helper'

describe file('/etc/audit/audit.rules') do
  its(:content) { should match /passwd_changes/ }
end

describe file('/var/log/audit/audit.log') do
  its(:content) { should match %r"/etc/passwd.*nametype=CREATE" }
end
