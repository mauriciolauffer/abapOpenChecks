class ZCL_AOC_CHECK_08 definition
  public
  inheriting from ZCL_AOC_SUPER
  create public .

public section.

*"* public components of class ZCL_AOC_CHECK_08
*"* do not include other source files here!!!
  methods CONSTRUCTOR .

  methods CHECK
    redefinition .
  methods GET_MESSAGE_TEXT
    redefinition .
protected section.
*"* protected components of class ZCL_AOC_CHECK_08
*"* do not include other source files here!!!
private section.
ENDCLASS.



CLASS ZCL_AOC_CHECK_08 IMPLEMENTATION.


METHOD check.

* abapOpenChecks
* https://github.com/larshp/abapOpenChecks
* MIT License

  DATA: lv_include   TYPE sobj_name,
        lv_code      TYPE sci_errc,
        lv_token     TYPE string,
        lv_statement TYPE string.

  FIELD-SYMBOLS: <ls_token>     LIKE LINE OF it_tokens,
                 <ls_statement> LIKE LINE OF it_statements.


  LOOP AT it_statements ASSIGNING <ls_statement>.

    CLEAR lv_statement.

    LOOP AT it_tokens ASSIGNING <ls_token>
        FROM <ls_statement>-from TO <ls_statement>-to.
      IF <ls_token>-type <> scan_token_type-identifier.
        lv_token = 'SOMETHING'.
      ELSE.
        lv_token = <ls_token>-str.
      ENDIF.

      IF lv_statement IS INITIAL.
        lv_statement = lv_token.
      ELSE.
        CONCATENATE lv_statement lv_token INTO lv_statement SEPARATED BY space.
      ENDIF.
    ENDLOOP.

    CLEAR lv_code.

    IF lv_statement CP 'REFRESH *'.
      lv_code = '001'.
    ELSEIF lv_statement CP '* IS REQUESTED*'.
      lv_code = '002'.
    ELSEIF lv_statement = 'LEAVE'.
      lv_code = '003'.
    ELSEIF lv_statement CP 'COMPUTE *'.
      lv_code = '004'.
    ELSEIF lv_statement CP 'MOVE *'.
      lv_code = '005'.
    ELSEIF lv_statement CP '* >< *'
        OR lv_statement CP '* =< *'
        OR lv_statement CP '* => *'.
      lv_code = '006'.
    ELSEIF lv_statement CP '* EQ *'
        OR lv_statement CP '* NE *'
        OR lv_statement CP '* LT *'
        OR lv_statement CP '* GT *'
        OR lv_statement CP '* LE *'
        OR lv_statement CP '* GE *'.
      lv_code = '007'.
    ELSEIF lv_statement CP 'DEMAND *'.
      lv_code = '008'.
    ELSEIF lv_statement CP 'SUPPLY *'.
      lv_code = '009'.
    ELSEIF lv_statement CP 'CONTEXTS *'.
      lv_code = '010'.
    ELSEIF lv_statement CP 'ADD *'.
      lv_code = '011'.
    ELSEIF lv_statement CP 'SUBTRACT *'.
      lv_code = '012'.
    ELSEIF lv_statement CP 'MULTIPLY *'.
      lv_code = '013'.
    ELSEIF lv_statement CP 'DIVIDE *'.
      lv_code = '014'.
    ELSEIF lv_statement CP 'CALL DIALOG *'.
      lv_code = '015'.
    ELSEIF lv_statement CP '* OCCURS *'.
      lv_code = '016'.
    ELSEIF lv_statement CP '* WITH HEADER LINE *'.
      lv_code = '017'.
    ELSEIF lv_statement CP 'RANGES *'.
      lv_code = '018'.
    ELSEIF lv_statement CP 'ADD-CORRESPONDING *'
        OR lv_statement CP 'SUBTRACT-CORRESPONDING *'
        OR lv_statement CP 'MULTIPLY-CORRESPONDING *'
        OR lv_statement CP 'DIVIDE-CORRESPONDING *'.
      lv_code = '019'.
    ENDIF.

    IF NOT lv_code IS INITIAL.
      lv_include = get_include( p_level = <ls_statement>-level ).
      inform( p_sub_obj_type = c_type_include
              p_sub_obj_name = lv_include
              p_line         = <ls_token>-row
              p_kind         = mv_errty
              p_test         = myname
              p_code         = lv_code ).
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD constructor.

  super->constructor( ).

  description    = 'Obsolete statement'.                    "#EC NOTEXT
  category       = 'ZCL_AOC_CATEGORY'.
  version        = '001'.
  position       = '008'.

  has_attributes = abap_true.
  attributes_ok  = abap_true.

  mv_errty = c_error.

ENDMETHOD.                    "CONSTRUCTOR


METHOD get_message_text.

  CASE p_code.
    WHEN '001'.
      p_text = 'REFRESH is obsolete'.                       "#EC NOTEXT
    WHEN '002'.
      p_text = 'IS REQUESTED is obsolete'.                  "#EC NOTEXT
    WHEN '003'.
      p_text = 'LEAVE is obsolete'.                         "#EC NOTEXT
    WHEN '004'.
      p_text = 'COMPUTE is obsolete'.                       "#EC NOTEXT
    WHEN '005'.
      p_text = 'MOVE is obsolete'.                          "#EC NOTEXT
    WHEN '006'.
      p_text = 'Obsolete operator'.                         "#EC NOTEXT
    WHEN '007'.
      p_text = 'Use new operator'.                          "#EC NOTEXT
    WHEN '008'.
      p_text = 'DEMAND is obsolete'.                        "#EC NOTEXT
    WHEN '009'.
      p_text = 'SUPPLY is obsolete'.                        "#EC NOTEXT
    WHEN '010'.
      p_text = 'CONTEXTS is obsolete'.                      "#EC NOTEXT
    WHEN '011'.
      p_text = 'ADD is obsolete'.                           "#EC NOTEXT
    WHEN '012'.
      p_text = 'SUBTRACT is obsolete'.                      "#EC NOTEXT
    WHEN '013'.
      p_text = 'MULTIPLY is obsolete'.                      "#EC NOTEXT
    WHEN '014'.
      p_text = 'DIVIDE is obsolete'.                        "#EC NOTEXT
    WHEN '015'.
      p_text = 'CALL DIALOG is obsolete'.                   "#EC NOTEXT
    WHEN '016'.
      p_text = 'OCCURS is obsolete'.                        "#EC NOTEXT
    WHEN '017'.
      p_text = 'WITH HEADER LINE is obsolete'.              "#EC NOTEXT
    WHEN '018'.
      p_text = 'RANGES declarations is obsolete'.           "#EC NOTEXT
    WHEN '019'.
      p_text = 'Arithmetic CORRESPONDING is obsolete'.      "#EC NOTEXT
    WHEN OTHERS.
      ASSERT 1 = 1 + 1.
  ENDCASE.

ENDMETHOD.                    "GET_MESSAGE_TEXT
ENDCLASS.