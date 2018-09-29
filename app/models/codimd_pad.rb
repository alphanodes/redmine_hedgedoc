class CodimdPad
  def self.pads
    CodimdNote.where('title is NOT NULL')
              .where("permission!='private'")
              .order(updatedAt: :desc)
  end
end
