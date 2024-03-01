var selectedImage = null;
            $("#maskMenu").hide();
            function setImage(id) {
                selectedImage = id;
                document.getElementById("modify").disabled = false;
            }

            $(function () {

                function doOpen(bool) {
                    if (bool) {
                        $("#maskMenu").show();
                    } else {
                        $("#maskMenu").hide();
                    }
                }

                window.addEventListener('message', (event) => {
                    if (event.data.display == true) {
                        document.getElementById("modify").disabled = true;
                        doOpen(true);
                    } else {
                        doOpen(false);
                    }
                });
                
                $("#modify").click(function () {
                    if (selectedImage != null) {
                        $.post(`https://${GetParentResourceName()}/setTexture`, JSON.stringify({
                            texture: selectedImage
                        }));
                        console.log("Modified image: " + selectedImage);
                        return
                    }
                    else {
                        $.post(`https://${GetParentResourceName()}/error`, JSON.stringify({
                            error: "No image was selected"
                        }));
                        console.log("No image selected");
                        return
                    }
                })
                
                $("#close").click(function () {
                    $.post(`https://${GetParentResourceName()}/closeGUI`, JSON.stringify({}));
                    console.log("Cancel pressed");
                    return
                })

                document.onkeyup = function(data) {
                    if (data.which == 27) {
                        $.post(`https://${GetParentResourceName()}/closeGUI`, JSON.stringify({}));
                        console.log("escape pressed");
                        return
                    }
                }
            })