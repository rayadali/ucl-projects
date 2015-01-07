/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ast;

/**
 *
 * @author suneeta
 */
public class TypeDeclNode extends Node
{
    public String id;
    public String type;

    public TypeDeclNode(String id, String type, Node expr) {
	this.id = id;
        this.type = type;
        this.left = expr;
        this.right = null;
    }

    public Object accept(Visitor v) {
        return v.visit(this);
    }

}
