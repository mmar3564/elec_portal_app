class TopicsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]  
  before_filter :admin_required, :only => :destroy
  def index
    @topics = Topic.all
  end
 
  def show
    @topic = Topic.find(params[:id])
  end
 
  def new
    @topic = Topic.new
  end
 
  def create
    @forum = Forum.find(params[:topic][:forum_id])
    @topic = @forum.topics.create(:name => params[:topic][:name], :last_poster_id => current_user.id, :forum_id => @forum.id, :user_id => current_user.id)
     
    if @topic.save
        redirect_to "/forums/#{@topic.forum_id}"
    else
      render :action => 'new'
    end
end
 
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to "/forums/#{@topic.forum_id}"
  end
end