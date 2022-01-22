require 'rails_helper'

describe NotesController, type: :controller do
  render_views

  it 'should get new page' do
    get :new
    expect(response).to have_http_status(302)
    expect(response).to redirect_to(signin_path)
  end

  it 'should get index page' do
    get :index
    expect(response).to have_http_status(302)
    expect(response).to redirect_to(signin_path)
  end
end
