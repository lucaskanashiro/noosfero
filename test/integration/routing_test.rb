require "#{File.dirname(__FILE__)}/../test_helper"

class RoutingTest < ActionController::IntegrationTest

  # home page
  ################################################################
  def test_homepage
    assert_routing('/', :controller => 'home', :action => 'index')
  end

  # user-targeted controllers (account/*, cms/*, customize/*)
  ################################################################
  def test_account_controller
    assert_routing('/account', :controller => 'account', :action => 'index')
  end

  def test_enterprise_registration_controller
    assert_routing('/enterprise_registration', :controller => 'enterprise_registration', :action => 'index')
    assert_routing('/enterprise_registration/lala', :controller => 'enterprise_registration', :action => 'lala')
  end

  def test_new_password
    assert_routing('/account/new_password/90dfhga7sadgd0as6saas', :controller => 'account', :action => 'new_password', :code => '90dfhga7sadgd0as6saas')
  end

  def test_cms
    assert_routing('/myprofile/ze/cms', :profile => 'ze', :controller => 'cms', :action => 'index')
  end

  def test_edit_template
    # FIXME: this is wrong
    assert_routing('/admin/edit_template', :controller => 'edit_template', :action => 'index')
  end

  def test_profile_editor
    assert_routing('/myprofile/ze', :profile => 'ze', :controller => 'profile_editor', :action => 'index')
  end

  # environment administrative controllers (admin/*)
  ################################################################

  def test_admin_panel_controller
    assert_routing('/admin', :controller => 'admin_panel', :action => 'index')
  end

  def test_features_controller
    assert_routing('/admin/features', :controller => 'features', :action => 'index')
    assert_routing('/admin/features/update', :controller => 'features', :action => 'update')
  end

  def test_categories_management
    assert_routing('/admin/categories', :controller => 'categories', :action => 'index')
    assert_routing('/admin/categories/new', :controller => 'categories', :action => 'new')
    assert_routing('/admin/categories/edit/2', :controller => 'categories', :action => 'edit', :id => '2')
  end

  # platform administrative controllers (system/*)
  ################################################################

  # external public controllers
  ################################################################
  def test_content_viewer

    # profile root:
    assert_routing('/ze', :controller => 'content_viewer', :action => 'view_page', :profile => 'ze', :page => [])

    # some non-root page
    assert_routing('/ze/work/2007', :controller => 'content_viewer', :action => 'view_page', :profile => 'ze', :page => ['work', "2007"])
  end

  def test_category_browser
    assert_routing('/cat/products/eletronics', :controller => 'category', :action => 'view', :path => [ 'products', 'eletronics'])
    assert_routing('/cat', :controller => 'category', :action => 'index')
  end

  #FIXME remove this if design_blocks is not going to be used; or uncomment otherwise;
  #def test_routing_to_controllers_inside_design_blocks_directory
  #  assert_routing('/block/cojones/favorite_links_profile/show/1', :profile => 'cojones', :controller => 'favorite_links_profile', :action => 'show', :id => '1')
  #  assert_routing('/block/cojones/favorite_links_profile/save', :profile => 'cojones', :controller => 'favorite_links_profile', :action => 'save')

  #  assert_routing('/block/cojones/list_block/show/1', :profile => 'cojones', :controller => 'list_block', :action => 'show', :id => '1')
  #end

  def test_tag_viewing
    assert_routing('/tag', :controller => 'search', :action => 'tags')
    assert_routing('/tag/umboraminhaporra', :controller => 'search', :action => 'tag', :tag => 'umboraminhaporra')
  end

  def test_profile_routing
    assert_routing('/profile/ze', :controller => 'profile', :profile => 'ze', :action => 'index')
    assert_routing('/profile/ze/friends', :controller => 'profile', :profile => 'ze', :action => 'friends')
  end

end
