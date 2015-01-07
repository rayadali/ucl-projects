/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ast;

/**
 *
 * @author suneeta
 */
public class GNode extends Node
{

    public GNode(Node left, Node right) {
	this.left=left;
	this.right=right;
    }

    public Object accept(Visitor v) {
        return v.visit(this);
    }

}
