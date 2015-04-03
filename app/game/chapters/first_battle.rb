class FirstBattle < Tale::Chapter

  event do
    agent :large_man
    detail "The large man swings at you with his fist"
    action :dodge, label: "Dodge"
    action :block, label: "Block"
  end

end