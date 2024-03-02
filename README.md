ph_papermask v1.1
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
    Or any other icons for the paper masks as none are provided

Installation
-----------------
- Download the latest version of ph_papermask
- Place the ph_papermask directory in your resources directory
- Add ensure ph_papermask to your server.cfg file
- Add your chosen mask icon images to ox_inventory/web/images/ named as papermask#.png and to ph_papermask/web/images/ named as #.png (# is the texture id for the mask variation)
- Add the items from INSTALL/items.lua to your ox_inventory/data/items.lua file

Configuration
-----------------
No Config file implemented yet, but you can change the code to suit your needs.
To implement notifications just replace the print() in code with calls to your notification system.

Usage
-----------------
- in your inventory screen right click a paper bag and select 'modify' to open the convert mask UI
- In inventory use a mask to wear it, use again to remove the mask

known issue
-----------------
- if a player logs out while wearing a mask, when they log back in they wont have mask on but wont be able to drop the mask until they wear it and remove it again.
(the above issue will likely remain unfixed as it would require hooking into what ever clothing script you use to save skins, you can easily add the call yourself in the server.lua)

Roadmap
-----------------
- add config file
- implement requirement for a marker pen in inventory to convert mask
- add a default notification system for messages to player

Changelog 
-----------------
v1.1 (02/03/2024)
-----------------
- Made it so you can't remove mask item from inventory while worn
- modified code to use ox_inventory hooks to make it a bit cleaner
- force close inventory while modifying to avoid a glitch, if you had just opened the paperbag storage you would still have access to that inventory after modifying
