module ControllerMacros

  def login_first_user
    before(:each) do
      request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user, :id => 1)
      request.env['warden'].stub :authenticate! => user
      controller.stub :current_user => user
      sign_in user
    end
  end

end
