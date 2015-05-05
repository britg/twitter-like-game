class StatBuild < ObjectBuild

  def props
    {
      name: @hash["name"],
      slug: @hash["slug"],
    }
  end

  def create
    @stat = Stat.create(props)
  end

  def update
    @stat = existing
    @stat.update_attributes(props)
    @stat
  end

end
