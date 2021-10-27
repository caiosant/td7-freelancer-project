require 'rails_helper'

describe 'Property Owner authentication' do
    context 'project' do
        it 'cannot open new project form unless authenticated' do
            get new_project_path

            expect(response).to redirect_to(new_project_owner_session_path)
        end

        it 'cannot create property without login' do
            post '/projects'

            expect(response).to redirect_to(new_project_owner_session_path)
        end
    end
end