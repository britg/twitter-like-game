class BranchTest < Tale::Chapter

  event do
    detail "Start"
    action :b1, label: "Branch 1"
    action :b2, label: "Branch 2"
  end

  branch :b1 do

    event do
      detail "Branch 1 action 1"
      action :continue, label: "Continue branch 1"
    end

    event do
      detail "Branch 1 action 2"
    end

  end

  branch :b2 do
    event do
      detail "Branch 2 action 1"
      action :continue, label: "Continue branch 2"
    end

    event do
      detail "Branch 2 action 2"
    end
  end

  event do
    detail "Back together"
  end

end