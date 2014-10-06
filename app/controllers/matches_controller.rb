class MatchesController < ApplicationController
  def update
  	  #render text: params.inspect
      @match = Match.find(params[:id])
	  #if @multichoicequestion.update(params[:multichoicequestion].permit(:name, :quiz_id, :question,:media, :audio, :image, :choice_label_display_mode, :choice1, :choice2, :choice3, :answer))
	  
	  #Multichoicequestion.new(multichoicequestion_params)
	  
	  if @match.update(match_params)
	  	redirect_to match_path
	  else
	    render 'edit'
	  end 

  end
    private
	def match_params
	params.require(:match).permit(:match, :answer)
  end
end
