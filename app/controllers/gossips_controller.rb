class GossipsController < ApplicationController

  #l'utilisateur doit être connecté pour créer un gossip ou le modifier
  before_action :authenticate_user, only: [:new, :edit, :destroy]

  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage

    #On souhaite la bienvenue différemment si le user est connecté ou pas
    logged_in? ? @welcome = "Hello #{current_user.first_name}, ravi de te revoir" : @welcome = "Bienvenue"

    @gossips = []
    Gossip.all.each do |my_gossip|
      @gossips << {author: my_gossip.user.first_name, title: my_gossip.title, user_id: my_gossip.user.id, id: my_gossip.id, city: City.find(my_gossip.user.city_id).name}
    end
  end

  def show
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    my_gossip = Gossip.find(params[:id])

    @x = my_gossip #Variable qu'on utilisera plus tard pour la création du formulaire des commentaires

    my_city = City.find(my_gossip.user.city_id)
    @gossip = {id: my_gossip.id, author: my_gossip.user.first_name, title: my_gossip.title, user_id: my_gossip.user.id, content: my_gossip.content, created_at: my_gossip.created_at, city: my_city.name}

    #On récupère les commentaires à afficher
    @gossip_comments = my_gossip.comments

    #On initialise un commentaire null pour pouvoir afficher le formulaire des commentaires
    @gossip_comment = Comment.new

  end

  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    @gossip = Gossip.new
  end


  def create
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
    my_gossip = {content: params[:gossip][:content], title: params[:gossip][:title]}
    @gossip = Gossip.new(title: my_gossip[:title], content: my_gossip[:content], user_id: current_user.id)

    respond_to do |format|
      if @gossip.save
        format.html { redirect_to @gossip, notice: 'Ton potin a bien été créé' }
        format.json { render :show, status: :created, location: @gossip }
      else
        format.html { render :new }
        format.json { render json: @gossip.errors, status: :unprocessable_entity }
      end
    end

  end


  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @gossip= Gossip.find(params[:id])
  end


  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    @gossip= Gossip.find(params[:id])
    @gossip.update(gossip_params)

    redirect_to gossips_path

  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
    @gossip= Gossip.find(params[:id])

    @gossip.destroy
    redirect_to gossips_path
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  #Vérifier que le user est connecté pour gossiper
  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end
