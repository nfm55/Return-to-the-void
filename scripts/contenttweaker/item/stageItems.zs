#priority 2000
#loader contenttweaker
//导包
    import mods.contenttweaker.VanillaFactory;
    import mods.contenttweaker.Item;
    import mods.contenttweaker.IItemRightClick;
    import mods.contenttweaker.Commands;
    import mods.contenttweaker.MutableItemStack;

    global stageItems as string[string] = {
        knowledge_of_elf : "one",
		knowledge_of_bloody_act : "two"
    };

    function createStageItem(name as string, stage as string){
        var item = VanillaFactory.createItem(name);
        item.maxStackSize = 64;
        item.rarity = "EPIC";
        item.itemRightClick = function(stack, world, player, hand) {
                print(stack.name);
                Commands.call("gamestage add "+player.name+" "+stageItems[stack.name.substring(20)], player, world, false, true);
                Commands.call("title "+player.name+" title {\"text\":\"您已解锁新阶段！\"}", player, world, false, true);
                Commands.call("summon minecraft:fireworks_rocket "+player.x+" "+(player.y+2)+" "+player.z+" {LifeTime:30,FireworksItem:{id:fireworks,Count:1,tag:{Fireworks:{Flight:1,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;11743532,3887386,2437522,8073150,4408131,14188952,4312372,14602026,15435844,15790320],FadeColors:[I;2437522,14188952,4312372,14602026]}]}}}}", player, world, false, true);
                Commands.call("playsound minecraft:ui.toast.challenge_complete player "+player.name, player, world, false, true);
                stack.shrink(1);
                return "Success";
            };
        item.register();
    }

//注册物品
    for key in stageItems{
        createStageItem(key, stageItems[key]);
    }
