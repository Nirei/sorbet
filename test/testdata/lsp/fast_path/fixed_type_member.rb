# typed: true

class Box
  extend T::Sig
  extend T::Generic

  Elem = type_member

  sig {params(x: Elem).void}
  def parent_ex(x)
    T.reveal_type(x) # error: `Box::Elem`
  end
end

class IntBox < Box
  Elem = type_member { {fixed: Integer} }

  sig {params(x: Elem).void}
  def child_ex(x)
    T.reveal_type(x) # error: `Integer`
  end
end

Box[Integer].new.parent_ex('')
#                          ^^ error: Expected `Integer` but found `String("")` for argument `x`
IntBox.new.parent_ex('')
#                    ^^ error: Expected `Integer` but found `String("")` for argument `x`
IntBox[Integer].new
#      ^^^^^^^ error: Wrong number of type parameters
