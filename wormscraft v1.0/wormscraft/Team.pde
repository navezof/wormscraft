class Team {
  private String _name;
  public List<Charater> _pl;
  
  Team(String name) {
    _name = name;
    _pl = new ArrayList<Charater>();
  }
  
  public String getName() {
    return _name;
  }
  
  public int getNbMember() {
   return _pl.size(); 
  }
}
