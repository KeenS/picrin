#include "picrin.h"
#include "picrin/data.h"
#include "picrin/string.h"

#include <mecab.h>

static void
mecab_dtor(pic_state *pic, void *data)
{
  UNUSED(pic);
  mecab_destroy((mecab_t *) data);
}

static const pic_data_type mecab_type = { "mecab", mecab_dtor };

#define pic_mecab_p(o) (pic_data_type_p((o), &mecab_type))
#define pic_mecab_ptr(o) ((mecab_t *)pic_data_ptr(o)->data)

static pic_value
pic_mecab_new(pic_state *pic)
{
  char *flags;

  pic_get_args(pic, "z", &flags);

  return pic_obj_value(pic_data_alloc(pic, &mecab_type ,mecab_new2(flags)));
}

static pic_value
pic_mecab_parse(pic_state *pic)
{
  char *input;
  const char *result;
  pic_value obj;
  mecab_t *mec;

  pic_get_args(pic, "oz", &obj, &input);

  if(! pic_mecab_p(obj)){
    pic_errorf(pic, "mecab required");
  }

  mec = pic_mecab_ptr(obj);
  result = mecab_sparse_tostr(mec, input);

  return pic_obj_value(pic_str_new_cstr(pic, result));
}

void
pic_init_mecab(pic_state *pic)
{
  pic_deflibrary ("(picrin mecab)") {
    pic_defun(pic, "make-mecab", pic_mecab_new);
    pic_defun(pic, "regexp-replace", pic_mecab_parse);
  }
}
