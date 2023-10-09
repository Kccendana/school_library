class ActionInterface
  def create
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  def list_all
    raise NotImplementedError, 'Subclasses must implement this method'
  end
end
