class NotesController < ApplicationController
  before_action :set_note, only: %i[show edit update destroy]
  before_action :check_view_access, only: %i[show edit]
  before_action :check_modify_access, only: %i[update destroy]

  # GET /notes or /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  def show; end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit; end

  # POST /notes
  def create
    @note = Note.new(note_params)
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: t('notes.messages.created') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to note_url(@note), notice: t('notes.messages.updated') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: t('notes.messages.destroyed') }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:title, :content, :notify_at)
  end

  def find_user_id(username)
    username.presence && User.find_by(username: username)&.id
  end

  def check_view_access
    method_not_allowed unless @note.user == current_user # || @note.public
  end

  def check_modify_access
    method_not_allowed unless @note.user == current_user
  end
end
