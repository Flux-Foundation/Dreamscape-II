
class WhitewashEffect extends LXEffect {
  WhitewashEffect(LX lx) {
    super(lx);
  }
  
  protected void run(double deltaMs) {
    for (LXPoint p : ((Model)lx.model).lampPosts.get(0).points) {
        colors[p.index] = LXColor.WHITE;
    }
  }
}

class Whitewash2Effect extends LXEffect {
  Whitewash2Effect(LX lx) {
    super(lx);
  }
  
  protected void run(double deltaMs) {
    for (LXPoint p : ((Model)lx.model).lampPosts.get(1).points) {
        colors[p.index] = LXColor.WHITE;
    }
  }
}

