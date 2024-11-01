
#include <iostream>
#include <vector>
#include <string>

class InNode {
private:
  std::string name;
  InNode *enclosed;
  std::vector<InNode*> children;
  std::vector<InNode*> enclosedCalls;
  bool enabled;
public:
  InNode(std::string name="");
  void addChild(InNode *withNode);
  void run();
  void setEnabled(bool enabled);
  void setEnclosed(InNode *enclosed);
private:
  void pushEnclosedCall(InNode *node);
  void callOut();
};

InNode::InNode(std::string name): enclosed(0), name(name), enabled(true) {
}
void InNode::addChild(InNode *withNode) {
  children.push_back(withNode);
}
void InNode::run() {
  if(enabled) {
    std::cout << "'" << name << "'.begin\n";

    if(enclosed) {
      enclosed->pushEnclosedCall(this);
      enclosed->run();
    }

    if(!enclosed) {
      for(int i=0;i<(int)children.size();i++) {
	children[i]->run();
      }
    }

    if(!children.size() && enclosedCalls.size() && !enclosed) {
      callOut();
    }

    std::cout << "'" << name << "'.end\n";
  }
}
void InNode::setEnabled(bool enabled) {
  this->enabled = enabled;
}
void InNode::setEnclosed(InNode *enclosed) {
  this->enclosed = enclosed;
}
void InNode::pushEnclosedCall(InNode *node) {
  if(enabled) {
    if(!children.size()) {
      enclosedCalls.push_back(node);
    }

    for(int i=0;i<(int)children.size();i++) {
      children[i]->pushEnclosedCall(node);
    }
  }
}
void InNode::callOut() {
  if(enabled) {
    InNode *enclosedCall = enclosedCalls.back();
    enclosedCalls.pop_back();

    for(int i=0;i<(int)enclosedCall->children.size();i++) {
      enclosedCall->children[i]->run();
    }

    if(!enclosedCall->children.size() && enclosedCall->enclosedCalls.size()) {
      enclosedCall->callOut();
    }
  }
}

int main() {
  InNode a("a"), b("b"), c("c"), d("d"), e("e"), f("f");
  a.addChild(&b);
  a.addChild(&c);

  d.addChild(&e);
  d.addChild(&f);

  a.setEnclosed(&d);


  a.run();
  return 0;
}
