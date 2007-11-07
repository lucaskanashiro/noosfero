class RoleController < EnvironmentAdminController
  protect 'manage_environment_roles', :environment

  def index
    @roles = Role.find(:all)
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to :action => 'show', :id => @role
    else
      flash[:notice] = _('Failed to create role')
      render :action => 'new'
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to :action => 'show', :id => @role
    else
      flash[:notice] = _('Failed to edit role')
      render :action => 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    if @role.destroy
      redirect_to :action => 'index'
    else
      flash[:notice] = _('Failed to edit role')
      redirect_to :action => 'index'
    end
  end
end
