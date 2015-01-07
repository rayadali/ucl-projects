package ast;

/**
 *
 * @author suneeta
 */
public class DeclNode extends Node
{
    public String id;
    public String type;

    public DeclNode(String id, String type) {
	this.id = id;
        this.type = type;
        this.left = null;
        this.right = null;
    }

    public Object accept(Visitor v) {
        return v.visit(this);
    }

}
