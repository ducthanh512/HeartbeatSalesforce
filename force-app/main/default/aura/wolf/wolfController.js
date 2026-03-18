({
    toggleHowl: function(component, event, helper) {
        var current = component.get("v.isHowling");
        component.set("v.isHowling", !current);
    }
})
