/** @file
 * @brief Script dialog
 *
 * This dialog is for launching scripts whose main purpose is
 * the scripting of Inkscape itself.
 */
/* Authors:
 *   Bob Jamison
 *   Other dudes from The Inkscape Organization
 *
 * Copyright (C) 2004, 2005 Authors
 *
 * Released under GNU GPL, read the file 'COPYING' for more information
 */

#ifndef __SCRIPTDIALOG_H__
#define __SCRIPTDIALOG_H__

#include "ui/widget/panel.h"
#include "verbs.h"

namespace Inkscape {
namespace UI {
namespace Dialog {


/**
 * A script editor, loader, and executor
 */
class ScriptDialog : public UI::Widget::Panel
{

    public:
    ScriptDialog() : 
     UI::Widget::Panel("", "/dialogs/script", SP_VERB_DIALOG_SCRIPT)
    {}

    /**
     * Helper function which returns a new instance of the dialog.
     * getInstance is needed by the dialog manager (Inkscape::UI::Dialog::DialogManager).
     */
    static ScriptDialog &getInstance();

    virtual ~ScriptDialog() {};

}; // class ScriptDialog


} //namespace Dialog
} //namespace UI
} //namespace Inkscape

#endif /* __DEBUGDIALOG_H__ */

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
