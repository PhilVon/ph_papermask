ph_papermask v2.0
-----------------

Overview
-----------------
ph_papermask is a FiveM resource that allows players to convert paperbag's to player masks and wear them.

Features
-----------------
- Convert a paperbag into a mask
- Allows players to wear paper masks
- Supports all papermasks in GTA5
- Implements OX_inventory to allow for conversion and wearing of mask

Requirements
-----------------
- ox_inventory (https://github.com/overextended/ox_inventory)

- [recommended] Clothes as item - 24k Drawn icons OF MP ped (https://forum.cfx.re/t/clothes-as-item-24k-drawn-icons-of-mp-ped/5183496)
    Or any other icons (some have been provided Thanks to [AdvancedTeam](https://forum.cfx.re/u/AdvancedTeam))

Installation
-----------------
- Download the latest version of ph_papermask
- Place the ph_papermask directory in your resources directory
- Add ensure ph_papermask to your server.cfg file
- copy all images from INSTALL/images to your ox_inventory/web/images directory
- Add the items from INSTALL/items.lua to your ox_inventory/data/items.lua file

Configuration
-----------------
For configuration options read and edit the config.lua to your liking

Usage
-----------------
- in your inventory screen right click a paper bag and select 'modify' to open the convert mask UI
- In inventory use a mask to wear it, use again to remove the mask

known issue
-----------------
- if a player logs out while wearing a mask, when they log back in they wont have the mask on but wont be able to drop the mask until they wear it and remove it again.
(the above issue will likely remain unfixed as it would require hooking into what ever clothing script you use to save skins, you can easily add the call yourself in the server.lua)

Roadmap
-----------------
- ~~add config file~~
- ~~implement requirement for a marker pen in inventory to convert mask~~
- add a default notification system for messages to player (leaning toward using ox_lib)

Changelog 
-----------------
v2.0 (03/03/2024)
-----------------
- Added inventory images for mask variations and marker pen
- Added Marker pen requirement
- Added config file
- Added options to modify colours of UI within the config.lua (standard RGB also the ability to set alpha transparency)

-----------------
v1.1 (02/03/2024)
-----------------
- Made it so you can't remove mask item from inventory while worn
- modified code to use ox_inventory hooks to make it a bit cleaner
- force close inventory while modifying to avoid a glitch, if you had just opened the paperbag storage you would still have access to that inventory after modifying
