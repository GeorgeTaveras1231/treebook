module LikesHelper

  def model_likes_path(model)
    name = model.class.name.downcase
    meth = "#{name}_likes_path"
    send(meth.to_sym,model)
  end

  def model_like_path(model)
    name = model.class.name.downcase
    meth = "#{name}_like_path"
    send(meth.to_sym, model, current_user.like(model))
  end
end
