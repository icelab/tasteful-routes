require 'spec_helper'

describe :tasteful_routes do
  before(:all) do
    @set = ActionDispatch::Routing::RouteSet.new
    @set.draw do
      resources :clients

      resources :posts do
        resources :comments
      end

      tasteful_resources :projects

      tasteful_resources :jobs do
        tasteful_resources :items
      end
    end

    class RouteTesting; end
    RouteTesting.send :include, @set.url_helpers

    @routes = RouteTesting.new
  end

  context "Not breaking existing behavior" do
    context "of resources" do
      specify "collection paths" do
        @routes.send(:clients_path).should == "/clients"
      end

      specify "member paths" do
        @routes.send(:client_path, 1).should == "/clients/1"
      end
    end

    context "of nested resources" do
      specify "collection paths" do
        @routes.send(:post_comments_path, 1).should == "/posts/1/comments"
      end

      specify "member paths" do
        @routes.send(:post_comment_path, 1, 12).should == "/posts/1/comments/12"
      end
    end
  end

  context "#tasteful_resources" do
    context "for non-nested resources" do
      it "should pluralize the collection paths" do
        @routes.send(:projects_path).should == "/projects"
      end

      it "should singularize the member paths" do
        @routes.send(:new_project_path).should == "/project/new"
        @routes.send(:project_path, 1).should == "/project/1"
        @routes.send(:edit_project_path, 1).should == "/project/1/edit"
      end
    end

    context "for the parent of nested resources" do
      it "should pluralize the collection paths" do
        @routes.send(:jobs_path).should == "/jobs"
      end

      it "should singularize the member paths" do
        @routes.send(:new_job_path).should == "/job/new"
        @routes.send(:job_path, 1).should == "/job/1"
        @routes.send(:edit_job_path, 1).should == "/job/1/edit"
      end
    end

    context "for the child of nested resources" do
      it "should pluralize the collection paths" do
        @routes.send(:job_items_path, 1).should == "/job/1/items"
      end

      it "should singularize the member paths" do
        @routes.send(:new_job_item_path, 1).should == "/job/1/item/new"
        @routes.send(:job_item_path, 1, 12).should == "/job/1/item/12"
        @routes.send(:edit_job_item_path, 1, 12).should == "/job/1/item/12/edit"
      end
    end
  end
end
