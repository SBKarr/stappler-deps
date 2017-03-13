/****************************************************************************
 Copyright (c) 2013-2014 Chukong Technologies Inc.

 http://www.cocos2d-x.org

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/


#ifndef _CC_GROUPCOMMAND_H_
#define _CC_GROUPCOMMAND_H_

#include <vector>
#include <unordered_map>

#include "base/CCRef.h"
#include "CCRenderCommand.h"
#include "CCRenderer.h"

/**
 * @addtogroup support
 * @{
 */

NS_CC_BEGIN

//Used for internal
class GroupCommandManager : public Ref
{
public:
    int getGroupID();
    void releaseGroupID(int groupID);

    inline std::vector<RenderQueue> *getRenderGroups() { return &_renderGroups; }
protected:
    friend class Renderer;

    /** Creates a render queue and returns its Id */
    int createRenderQueue();

    GroupCommandManager();
    ~GroupCommandManager();

    bool init();
    std::unordered_map<int, bool> _groupMapping;
    std::vector<int> _unusedIDs;

    std::vector<RenderQueue> _renderGroups;
};

/**
 GroupCommand is used to group several command together, and more, it can be nestd.
 So it is used to generate the hierarchy for the rendcommands. Evey group command will be assigned by a group ID.
 */
class CC_DLL GroupCommand : public RenderCommand
{
public:
    /**@{
     Constructor and Destructor.
     */
    GroupCommand();
    ~GroupCommand();
    /**@}*/

    /**Init function for group command*/
    void init(float globalOrder, const std::vector<int> &zPath);

    /**called by renderer, get the group ID.*/
    inline int getRenderQueueID() const {return _renderQueueID;}

protected:
    int _renderQueueID;
};

NS_CC_END

/**
 end of support group
 @}
 */
#endif //_CC_GROUPCOMMAND_H_
