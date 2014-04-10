class ProfileEditorController < MyProfileController

  protect 'edit_profile', :profile, :except => [:destroy_profile]
  protect 'destroy_profile', :profile, :only => [:destroy_profile]

  before_filter :access_welcome_page, :only => [:welcome_page]
  helper_method :has_welcome_page

  def index
    @pending_tasks = Task.to(profile).pending.without_spam.select{|i| user.has_permission?(i.permission, profile)}
  end

  helper :profile

  # edits the profile info (posts back)
  def edit
    @profile_data = profile
    @possible_domains = profile.possible_domains
    if request.post?
      params[:profile_data][:fields_privacy] ||= {} if profile.person? && params[:profile_data].is_a?(Hash)
      Profile.transaction do
      Image.transaction do
        if @profile_data.update_attributes(params[:profile_data])
          redirect_to :action => 'index', :profile => profile.identifier
        else
          profile.identifier = params[:profile] if profile.identifier.blank?
        end
      end
      end
    end
  end

  def enable
    @to_enable = profile
    if request.post? && params[:confirmation]
      unless @to_enable.update_attribute('enabled', true)
        session[:notice] = _('%s was not enabled.') % @to_enable.name
      end
      redirect_to :action => 'index'
    end
  end

  def disable
    @to_disable = profile
    if request.post? && params[:confirmation]
      unless @to_disable.update_attribute('enabled', false)
        session[:notice] = _('%s was not disabled.') % @to_disable.name
      end
      redirect_to :action => 'index'
    end
  end

  def update_categories
    @object = profile
    @categories = @toplevel_categories = environment.top_level_categories
    if params[:category_id]
      @current_category = Category.find(params[:category_id])
      @categories = @current_category.children
    end
    render :template => 'shared/update_categories', :locals => { :category => @current_category, :object_name => 'profile_data' }
  end

  def header_footer
    @no_design_blocks = true
    if request.post?
      @profile.update_header_and_footer(params[:custom_header], params[:custom_footer])
      redirect_to :action => 'index'
    else
      @header = boxes_holder.custom_header
      @footer = boxes_holder.custom_footer
    end
  end

  def destroy_profile
    if request.post?
      if @profile.destroy
        session[:notice] = _('The profile was deleted.')
        redirect_to :controller => 'home'
      else
        session[:notice] = _('Could not delete profile')
      end
    end
  end

  def welcome_page
    @welcome_page = profile.welcome_page || TinyMceArticle.new(:name => 'Welcome Page', :profile => profile, :published => false)
    if request.post?
      begin
        @welcome_page.update_attributes!(params[:welcome_page])
        profile.welcome_page = @welcome_page
        profile.save!
        session[:notice] = _('Welcome page saved successfully.')
        redirect_to :action => 'index'
      rescue Exception => exception
        session[:notice] = _('Welcome page could not be saved.')
      end
    end
  end

  private

  def has_welcome_page
    profile.person? && profile.is_template
  end

  def access_welcome_page
    unless has_welcome_page
      render_access_denied
    end
  end
end
