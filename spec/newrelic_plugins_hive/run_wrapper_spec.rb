require 'spec_helper'

describe NewRelicPluginsHive do
  before { NewRelicPluginsHive::RunWrapper.bypass_run }

  subject { ::NewRelic::Plugin::Run }

  its(:setup_and_run) { should == 'Bypassing setup_and_run'}
  it { should respond_to :orig_setup_and_run }
  it { expect { subject.orig_setup_and_run }.to raise_error Errno::ENOENT }
end
