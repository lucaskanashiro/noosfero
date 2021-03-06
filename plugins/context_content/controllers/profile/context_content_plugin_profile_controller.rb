class ContextContentPluginProfileController < ProfileController
  append_view_path File.join(File.dirname(__FILE__) + '/../../views')

  def view_content
    block = Block.find(params[:id])
    p = params[:page].to_i
    contents = block.contents(profile.articles.find(params[:article_id]), p)

    if contents
      render :update do |page|
        page.replace_html "context_content_#{block.id}", :file => "blocks/context_content", :locals => {:block => block, :contents => contents}
        page.replace_html "context_content_more_#{block.id}", :partial => 'blocks/more', :locals => {:block => block, :contents => contents, :article_id => params[:article_id] }
      end
    else
      render :text => "invalid page", :status => 500
    end
   end

end
