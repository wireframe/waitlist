require 'rails_helper'

RSpec.describe Prelaunch::SubscribersController do
  routes { Prelaunch::Engine.routes }

  describe '#new' do
    before do
      get :new
    end

    it { should respond_with(:ok) }
    it { should render_template :new }
  end

  describe '#create' do

    context 'with valid address' do
      before do
        post :create, subscriber: { email: 'valid.address@thegarage.us' }
      end

      it { should redirect_to root_url }
    end

    context 'as a json ajax request with invalid paramaters' do
      before do
        post :create, format: :json, subscriber: { email: "this isn't an email address" }
      end

      it { should respond_with 422 }

    end

    context 'with invalid address' do
      before do
        post :create, subscriber: { email: "this isn't an email address" }
      end

      it { should render_template :new }
    end
  end
end
