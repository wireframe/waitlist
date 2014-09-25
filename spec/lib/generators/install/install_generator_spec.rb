require 'rails_helper'
# FIXME: Figure out why 'require' doesn't work
load File.dirname(__FILE__) + '/../../../../lib/generators/prelaunch/install/install_generator.rb'

RSpec.describe Prelaunch::InstallGenerator, type: :generator do
  destination Rails.root + 'tmp/generated_files'

  before do
    routes = Rails.root + 'config/routes.rb'
    prepare_destination
    config_dir = File.join(destination_root, "config")
    FileUtils.mkdir_p(config_dir)
    File.open(File.join(config_dir, "routes.rb"), 'w') do |file|
      file.write("TestApp::Application.routes.draw do\n")
      file.write("end\n")
    end
    run_generator
  end
  describe "the migration" do
    subject { file(Rails.root + 'db/migrate/create_prelaunch_subscribers.prelaunch.rb') }

    it { is_expected.to be_a_migration }
  end
  describe "the routing entry" do
    subject { file('config/routes.rb') }
    it { is_expected.to contain /mount Prelaunch::Engine => "\/prelaunch"/ }
  end
end
