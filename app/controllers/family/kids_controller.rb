module Family
  class KidsController < BaseController
    before_action :set_kid, only: %i[edit update destroy]

    def index
      @kids = current_parent.kids
    end

    def new
      @kid = current_parent.kids.new
    end

    def create
      @kid = current_parent.kids.new(kid_params)
      if @kid.save
        redirect_to family_kids_path, notice: "#{@kid.name} is ready to read!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      attrs = kid_params
      attrs = attrs.except(:pin) if attrs[:pin].blank?
      if @kid.update(attrs)
        redirect_to family_kids_path, notice: "Saved."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @kid.destroy
      redirect_to family_kids_path, notice: "Removed."
    end

    private

    def set_kid
      @kid = current_parent.kids.find(params[:id])
    end

    def kid_params
      params.require(:kid).permit(:name, :age, :avatar, :pin)
    end
  end
end
