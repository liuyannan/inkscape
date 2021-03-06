#ifndef __NR_FILTER_COLOR_MATRIX_H__
#define __NR_FILTER_COLOR_MATRIX_H__

/*
 * feColorMatrix filter primitive renderer
 *
 * Authors:
 *   Felipe Corrêa da Silva Sanches <juca@members.fsf.org>
 *
 * Copyright (C) 2007 authors
 *
 * Released under GNU GPL, read the file 'COPYING' for more information
 */

#include <vector>
#include <2geom/forward.h>
#include "display/nr-filter-primitive.h"

namespace Inkscape {
namespace Filters {

class FilterSlot;

enum FilterColorMatrixType {
    COLORMATRIX_MATRIX,
    COLORMATRIX_SATURATE,
    COLORMATRIX_HUEROTATE,
    COLORMATRIX_LUMINANCETOALPHA,
    COLORMATRIX_ENDTYPE
};

class FilterColorMatrix : public FilterPrimitive {
public:
    FilterColorMatrix();
    static FilterPrimitive *create();
    virtual ~FilterColorMatrix();

    virtual void render_cairo(FilterSlot &slot);
    virtual bool can_handle_affine(Geom::Affine const &);
    virtual double complexity(Geom::Affine const &ctm);

    virtual void set_type(FilterColorMatrixType type);
    virtual void set_value(gdouble value);
    virtual void set_values(std::vector<gdouble> const &values);
private:
    std::vector<gdouble> values;
    gdouble value;
    FilterColorMatrixType type;
};

} /* namespace Filters */
} /* namespace Inkscape */

#endif /* __NR_FILTER_COLOR_MATRIX_H__ */
/*
  Local Variables:
  mode:c++
  c-file-style:"stroustrup"
  c-file-offsets:((innamespace . 0)(inline-open . 0)(case-label . +))
  indent-tabs-mode:nil
  fill-column:99
  End:
*/
// vim: filetype=cpp:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:fileencoding=utf-8:textwidth=99 :
