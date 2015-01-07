package ast;



public interface Visitor
{

    public Object visit (Node n);

    public Object visit (GNode n);
    public Object visit (TypeDeclNode n);
    public Object visit (DeclNode n);
    public Object visit (FuncDecNode n);
    public Object visit (ParamNode n);


}
