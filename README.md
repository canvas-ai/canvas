<br />
<br />

<p align="center">
    <img src="https://raw.githubusercontent.com/canvas-ai/canvas-electron/main/public/icons/logo_256x256.png" alt="Canvas Logo" width="96px">
</p>

<br />

<h1 align="center">Canvas</h1>
<h2 align="center">Contextualize your unstructured universe!</h2>

## Foreword / Beware!

This project was started a long^looong time ago (originally named "Workspaces") and was my first-ever Node.js + Electron endeavour. **Some code snippets you may stumble upon date back to the dark ages of my JS knowledge hence may insult, even hurt more experienced programmers**. In addition, 2020 to 2022 I took on a role as a freelance DevOps engineer for a major retail bank, which meant putting everything else besides the bare necessities on hold(people who suffered through a multimillion $$$ project behind schedule in this industry may know and most probably still vividly recall the pain). That being said, if you have any questions or need assistance with the setup, please do not hesitate to contact me directly. I will be more than happy to help!

## Note

- More information about the dev progress at [https://github.com/orgs/canvas-ai/projects/2](https://github.com/orgs/canvas-ai/projects/2)
- Project (this particular repo) ~~is using~~ **is no longer using  git subtrees**, for more details checkout
  - [canvas-server](https://github.com/canvas-ai/canvas-server)
  - [canvas-cli](https://github.com/canvas-ai/canvas-cli)
  - [canvas-electron](https://github.com/canvas-ai/canvas-server)
  - [canvas-browser-extensions](https://github.com/canvas-ai/canvas-browser-extensions)


## Basic Concepts | What is Canvas

Canvas is a cross-platform desktop overlay to help organize work / workflows, events and **data** into separate "contexts".

Contexts are represented by a tree structure resembling a file-system hierarchy; every tree node represents a separate layer filtering down all unstructured information fighting for your attention on a standard(tm) desktop setup(emails, notifications, chat messages, growing number of random browser tabs and ad-hoc download-extract-test-forget endeavors).

A Canvas context tree is designed to be dynamic, supporting frequent changes to accommodate any structure needed to be productive; example context tree:

```plain
universe://
    /Home
        /Music
        /Podcasts
            /Physics
            /Medicine
        /Library
            /Physics
            /Math
            /Medicine
        /New house
            /Heating
            /Electricity
            /Kitchen
                /Sinks
                /Materials
                    /Shinnoki
                    /Egger
                    /..
            /Project docs
                /Archicad
                /Sketchup
                /Twinmotion
    /Edu
        /AIT
        /Physics
    /Work
        /AirBnB
            /Atlas Apartment
            /Fountainhead Apartment
        /Cu$tomerA
                /Dev
                    /JIRA-1234
                    /JIRA-1237
                /Reports
                    /Compliance
                        /2022
                        /2023
        /SaaS Startup FOO
            /DC Frankfurt
                /network
        /Billing
            /acme llc
                /2022
                /2023
            /acme inc
                /2023
                    /08
```

**Context URL**
``universe://work/customer-a/reports``
will (presumably) return all reports for Customer A,

``universe://reports``
will return all reports indexed("linked") by the bitmap index of the "reports" layer for your entire universe.

You want to prevent having multiple layers representing the same data. "Reports", "reports_new", "reports2", "customera-reports" should be represented by one layer named "reports", leaving the context(layer order) handle the filtering for you.

This setup enables having the same data accessible through different, ad-hoc "filesystem-like" context paths:
``universe://photos/2023/06``
``universe://home/inspirations/kitchens``
``universe://travel/Spain/2023``
``universe://tasks/data-cleanup/2023/09``
For the above example, all contexts return (among other data) the same file `IMG_1234.jpg` - a picture of a nice kitchen from an airbnb we stayed at. As a bonus - regardless of where it is stored(the storage part is abstracted away via storeD). Same goes for tabs, notes or any other documents - including the entropy-rich content of my ~/Downloads and ~/Desktop folders.

There are 5 layer types:

- **Workspace**: Exportable, **shareable** collection of data sources and layers. By default, you start with an undifferentiated "universe". Workspaces in Canvas can have a primary color assigned. If they do, Canvas UI will automatically use gradients [of the primary workspace color] for individual data abstractions.

- **Canvas**: A layer with multiple context, feature and/or filter bitmaps assigned that can optionally store Canvas UI layout and UI applet data. Canvases are the central piece of a lets say unorthodox approach to desktop environments, but more on that later.

- **Context**: The default layer type that links a context url part to one and only one context bitmap.

- **Filter**: Represents a single filter or feature bitmap*; example: `universe://customer_a/:emails/:today`, where :emails represents the "data/abstraction/email" feature bitmap, :today represents the "filter/datetime/today" filter.

- **Label**: A noop layer with no context or feature bitmap links

## Why Canvas you ask

There are couple of motivating factors for this project:

- I never really liked the "desktop" UI/UX, stacked nor tiled, and now [due to more mature libraries, better tooling in general, AI] it is finally feasible to experiment on my own implementation without burning 1/4 of an average human lifespan while doing so
- I never liked the rigidness of a flat, "static" file system hierarchy, always wanted to have dynamic "views" on top of my data without unwanted duplication or too much manual effort(this dates back to 2007? at that time I found out msft once worked on a similar - fs as a db - concept)
- I kept collecting \_RESTORE\_ and \_TO\_SORT\_ folders within other random \_TO\_SORT\_ folders, had data on a growing number of USB sticks, memory cards, \<random cloud provider\> instances and computers at work and in our household. I want to know where my rare-studio-recording-2008.mp3 is located("asus mp3 player", smb://nas.lan/some/random/folder, file://deviceid/foo/bar/baz/Downloads, timecapsule gps coordinates :)
- I want to have a working "roaming profile" experience across all my devices. On linux, ideally container-based applications I can freeze on logout/undock and unfreeze on a different linux machine(main motivation behind my iolinux distro experiment ~2017-2018)
- I want to easily discover peers, share files and collaborate on documents hosted publicly or on my own infrastructure
- I want to use all my computing devices seamlessly; export an application menu, toolbox or applet(music player of my HiFi-connected pc) to my phone or tablet, have my Canvas timeline on my phone so that whenever I search for some emails or notes, I can easily use swipe and zoom gestures to zoom into the time-frame of interest and filter out data I work on on my main workstation
- Pin devices to specific workspaces or contexts(fe my work nb to universe://work)
- Have a workforce of personal Canvas-integrated context-aware, portable(as in, workstation->nb->phone->car->workstation) AI assistants that would keep track and monitor various tasks, notify me and work on basic tasks autonomously(not really an innovative idea, we'll see how the actually important realization part turns out!)
- Enable easy integration with other non-context-aware applications(kde/plasma activities were close but not close enough)

## Architecture

**Canvas server**
Moved to a separate repo:
- https://github.com/canvas-ai/canvas-server

Manages your entire (not exclusively digital) universe. Server hosts your global context tree, stores all layers and indexes all your Apps, Roles, Utils, Dotfiles and data. It is also a proxy between your data backends and your client, exporting your contextualized OS environment configuration through various transports(REST API, socket.io, IPC, webdav).

**Canvas clients**
Client repositories:
- https://github.com/canvas-ai/canvas-electron (default desktop client)
- https://github.com/canvas-ai/canvas-shell
- https://github.com/canvas-ai/canvas-cli
- https://github.com/canvas-ai/canvas-browser-extensions

Client runtime [on a linux OS] ensures all configured apps(flatpak), local roles(docker/podman), utils(stored), dotfiles(git) and data(stored) are available on your host system for the context you are currently working in. You can pin a canvas client to a specific workspace(context), for example say your work notebook to `universe://work` and your htpc to `universe://home/living-room`, both with its own (sub-)set of apps, roles, utils, dotfiles and data visibility limited to the pinned context subtree.

Some of the technologies used in no particular order:

- [Roaring bitmaps](https://roaringbitmap.org/)
- [LMDB](https://www.npmjs.com/package/lmdb) - Main in-process KV DB backend for storing document metadata and indexes(originally leveldb, currently evaluating pouchdb/couchdb)
- [FlexSearch](https://github.com/nextapps-de/flexsearch) - Fulltext search index, to-be replaced with ..bitmap indexes :)
- [express.js](https://expressjs.com/) - RestAPI and some of the UI elements like shared Workspaces or Canvases
- [socket.io](https://socket.io/) - Evaluated zeromq, wrote a custom nodejs net.ipc module(currently at services/\_old\_/net-ipc), currently socket.io
- [webdavd](https://github.com/OpenMarshal/npm-WebDAV-Server) - Canvas based dynamic Desktop and Downloads folders
- [cacache](https://www.npmjs.com/package/cacache) - Integral part of storeD for caching remote data locally
- [vLLM](https://github.com/vllm-project/vllm) - Currently evaluating as the LLM backend
- [electron](https://www.electronjs.org/) - Well ..it should be easy enough to migrate to a more lightweight solution later on
- [lancedb](https://github.com/lancedb/lancedb)

## Social

I'm trying to motivate myself to do daily code updates by doing not-yet-but-soon-to-be live coding sessions(~~usually ~5AM - 6AM CEST~~). Wouldn't watch any of the existing videos _yet_, mostly OBS audio tests and a showcase of sleep deprivation, but you can subscribe for updates nevertheless.

YT Channel + Some (royalty-free) music used in my videos
- https://www.youtube.com/@idnc.streams
- https://soundcloud.com/idnc-sk/sets

<br />

## Support this project

- **By contributing to the codebase**
- **By testing the application and reporting bugs**
- By sponsoring some quality coffee via
  - <https://opencollective.com/idncsk>
  - <https://www.buymeacoffee.com/idncsk>

**Any suggestions welcome** ("you should use \<module\> to do \<stuff\> instead of \<whatever nightmare you have currently implemented\>"), as a hobby-programmer this is really appreciated!

Thank you!
