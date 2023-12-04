require 'rails_helper'

RSpec.describe "Toys", type: :request do
  describe "GET /index" do
    it "gets a list of toys" do
      cat = Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      Toy.create(
        name: 'Toy Mouse',
        cat_id: cat.id
      )
      get '/toys'
      toy = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(toy.length).to eq 1
    end
  end
  describe "POST /create" do
    it "creates a toy" do
      cat = Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      toy_params = {
        toy: {
          name: 'Toy Mouse',
          cat_id: cat.id
        }
      }
      post '/toys', params: toy_params
      expect(response).to have_http_status(200)
      toy = Toy.first
      expect(toy.name).to eq 'Toy Mouse'
      expect(toy.cat_id).to eq cat.id
    end
    it "doesn't create a toy without a name" do
      cat = Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      toy_params = {
        toy: {
          cat_id: cat.id
        }
      }
      post '/toys', params: toy_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
    end
    it "doesn't create a toy without a cat_id" do
      cat = Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      toy_params = {
        toy: {
          name: 'Toy Mouse'
        }
      }
      post '/toys', params: toy_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['cat_id']).to include "can't be blank"
    end
  end
  describe "PATCH /update" do
    it "updates a toy with valid parameters" do
      cat = Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      toy = Toy.create(
        name: 'Toy Mouse',
        cat_id: cat.id
      )
      toy_params = {
        toy: {
          name: 'Laser Pointer'
        }
      }
      patch "/toys/#{toy.id}", params: toy_params
      expect(response).to have_http_status(200)
      toy.reload
      expect(toy.name).to eq 'Laser Pointer'
    end
    it "doesn't update a toy without valid parameters" do
      cat = Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      toy = Toy.create(
        name: 'Toy Mouse',
        cat_id: cat.id
      )
      toy_params = {
        toy: {
          name: ''
        }
      }
      patch "/toys/#{toy.id}", params: toy_params
      expect(response).to have_http_status(422)
    end
  end
  describe "DELETE /destroy" do
    it 'removes a toy' do
      cat = Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      toy = Toy.create(
        name: 'Toy Mouse',
        cat_id: cat.id
      )
      delete "/toys/#{toy.id}"
      expect(response).to have_http_status(200)
      toys = Toy.all
      expect(toys).to be_empty
    end
  end
end