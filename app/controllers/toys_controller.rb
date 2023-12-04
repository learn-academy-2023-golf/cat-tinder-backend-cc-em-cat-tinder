class ToysController < ApplicationController
    def index
        toys = Toy.all
        render json: toys
    end

    def create
        toy = Toy.create(toy_params)
        if toy.valid?
            render json: toy
        else
            render json: toy.errors, status: 422
        end
    end

    def update
        toy = Toy.find(params[:id])
        toy.update(toy_params)
        if toy.valid?
            render json: toy
        else
            render json: toy.errors, status: 422
        end
    end

    def destroy
        toy = Toy.find(params[:id])
        if toy.destroy
            render json: toy
        else
            render json: toy.errors
        end
    end

    private
    def toy_params
        params.require(:toy).permit(:name, :cat_id)
    end
end
