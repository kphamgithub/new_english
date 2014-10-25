NewEnglish::Application.routes.draw do
  get 'examquestions/index'

  get "scramblers/index"
  get "matches/update"
  #get "exams/new"
  #get "exams/index"
  #get "exams/show"
  get "clozequestions/new"
  get "clozequestions/index"
  get "classnotes/index"
  get "classnotes/new"
  get "vocadrills/index"
  get "vocadrills/new"
  mount Ckeditor::Engine => '/ckeditor'
  resources :lessonvocas

  get "vocabularies/index"
  get "vocabularies/new"
  get "matchquestions/index"
  get "lessons/index"
  get "sessions/new"
  get "welcome/index"
  get "welcome/index_user"
  get "welcome/index_song"
  get "welcome/index_story"
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  
  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  # get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  
	resources :todos

	 resources :classnotes
	 resources :exams do
	 	resources :examquestions do
			member do
				get 'take'
			end
			member do
				post 'processquestion'
				post 'remove_from_exam'
			end
		end
	 end
	 
  	 resources :lessons do
	    member do
		    get 'show_vocabulary'
			get 'add_vocabulary'
			post 'save_vocabulary'
			post 'remove_vocabulary'
			
			get 'add_user'
			post 'save_user'

			get 'delete_user'
			post 'remove_user'
			
		end
		resources :quizs do
			member do
				get 'add_questions'
				get 'add_questions_error'
				get 'take_quiz'
				post 'select_questions'
				post 'save_questions'
			end
			resources :quizquestions do
				member do
					get 'take'
				end
				member do
					post 'processquestion'
					post 'remove_from_quiz'
				end
			end
		end
	 end

		 resources :vocabularies do
		    member do
				get 'drills'
				get 'questions'
			end
		 end
		 
			resources :multichoicequestions do
				member do
					get 'take'
				end
				member do
					#post 'process_question'
					post 'remove_from_quiz'
				end
			end
		 
	 resources :users do
		member do
			get 'add_lesson'
			post 'update_lesson'
			get 'assign_level'
			post 'update_level'
		end	 
	    resources :quizs do
			member do
				get 'list_questionresults'
				post 'delete_questionresults'
			end
			resources :quizquestionresults
			
		end
	 end
	   
	 resources :sessions
	 
	 resources :scramblers do
		member do
			get 'take'
		end
		member do
		    #post 'process_question'
			post 'remove_from_quiz'
		end
	 end

	 
	 resources :fillquestions do
		member do
			get 'take'
		end
		member do
		    #post 'process_question'
			post 'remove_from_quiz'
		end
	 end

	 resources :matchquestions do
		member do
			get 'take'
		end
		member do
		    #post 'process_question'
			post 'remove_from_quiz'
		end
	 end

	 resources :clozequestions do
		member do
			get 'take'
		end
		member do
			post 'remove_from_quiz'
		end
	 end

	 
  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
