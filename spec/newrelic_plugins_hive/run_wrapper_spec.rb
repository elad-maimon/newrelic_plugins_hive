require 'spec_helper'

describe 'RunWrapper' do

  describe '.bypass_run' do
    before { NewRelicPluginsHive::RunWrapper.bypass_run }

    subject { ::NewRelic::Plugin::Run }

    its(:setup_and_run) { should == 'Bypassing setup_and_run'}
    it { should respond_to :orig_setup_and_run }
    it { expect { subject.orig_setup_and_run }.to raise_error Errno::ENOENT }
  end
  
  describe '.call_original_run' do
    it 'should call original setup_and_run' do
      ::NewRelic::Plugin::Run.should_receive(:orig_setup_and_run)
      NewRelicPluginsHive::RunWrapper.call_original_run
    end
  end
end
