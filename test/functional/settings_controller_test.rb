require File.expand_path('../../test_helper', __FILE__)

class SettingsControllerTestt < RedmineCodimd::ControllerTest
  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :enabled_modules,
           :enumerations,
           :attachments,
           :custom_fields,
           :custom_values,
           :journals,
           :journal_details,
           :queries

  def setup
    @controller = SettingsController.new
    User.current = nil
    @request.session[:user_id] = 1 # admin
  end

  def test_codimd_settings
    get :plugin,
        params: { id: 'redmine_codimd' }

    assert_response :success
    assert_select 'input#settings_codimd_url'
  end
end
