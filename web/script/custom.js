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
                        
                        // Set theme
                        var colorImageContainer = `rgba(${event.data.colors.cImgCnt.r}, ${event.data.colors.cImgCnt.g}, ${event.data.colors.cImgCnt.b}, ${event.data.colors.cImgCnt.a})`;
                        $('.images-container').css('background', colorImageContainer);
                        var colorButtonContainer = `rgba(${event.data.colors.cBtnCnt.r}, ${event.data.colors.cBtnCnt.g}, ${event.data.colors.cBtnCnt.b}, ${event.data.colors.cBtnCnt.a})`;
                        $('.buttons-container').css('background', colorButtonContainer);
                        var colorButton = `rgba(${event.data.colors.cBtnBg.r}, ${event.data.colors.cBtnBg.g}, ${event.data.colors.cBtnBg.b}, ${event.data.colors.cBtnBg.a})`;
                        $('.buttons-container button').css('background-color', colorButton);
                        var colorButtonText = `rgba(${event.data.colors.cBtnTxt.r}, ${event.data.colors.cBtnTxt.g}, ${event.data.colors.cBtnTxt.b}, ${event.data.colors.cBtnTxt.a})`;
                        $('.buttons-container button').css('color', colorButtonText);
                        var colorButtonHover = `rgba(${event.data.colors.cBtnHvr.r}, ${event.data.colors.cBtnHvr.g}, ${event.data.colors.cBtnHvr.b}, ${event.data.colors.cBtnHvr.a})`;
                        $('.buttons-container button:hover').css('background-color', colorButtonHover);
                        var colorScrollTrack = `rgba(${event.data.colors.cScrTrk.r}, ${event.data.colors.cScrTrk.g}, ${event.data.colors.cScrTrk.b}, ${event.data.colors.cScrTrk.a})`;
                        $('.images-container::-webkit-scrollbar-track').css('background', colorScrollTrack);
                        var colorScrollThumb = `rgba(${event.data.colors.cScrThm.r}, ${event.data.colors.cScrThm.g}, ${event.data.colors.cScrThm.b}, ${event.data.colors.cScrThm.a})`;
                        $('.images-container::-webkit-scrollbar-thumb').css('background', colorScrollThumb);
                        var colorScrollThumbHover = `rgba(${event.data.colors.cScrThmHvr.r}, ${event.data.colors.cScrThmHvr.g}, ${event.data.colors.cScrThmHvr.b}, ${event.data.colors.cScrThmHvr.a})`;
                        $('.images-container::-webkit-scrollbar-thumb:hover').css('background', colorScrollThumbHover);
                        
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