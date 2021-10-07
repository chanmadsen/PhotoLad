//
//  ChallengeController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 9/7/21.
//

import Foundation

class ChallengeController {
    
    static var challenges: [PhotoChallenge] {

        let one = PhotoChallenge(title: "Sunrise", challenge: "This challenge is all about the start of the day. You don’t have to shoot at sunrise for this theme, as long as the end picture makes you think about sunrise.")
        
        let two = PhotoChallenge(title: "Self Portrait", challenge: "By switching the focus from other subjects to yourself as the subject, your photography takes on a whole new perspective.")
        
        let three = PhotoChallenge(title: "Wisdom", challenge: "For the wisdom project, the goal is to gather photographs of those who have offered you wisdom or a helpful perspective. Aim to capture individuals in their natural state, especially if it’s in a location where they shared a special moment with you.")
        
        let four = PhotoChallenge(title: "Candid", challenge: "Photographing someone in their natural state allows for their true personality to shine through. With a candid photography project, incorporate a range of human subjects for a diverse collection, or capture the same subject across different settings and days.")
        
        let five = PhotoChallenge(title: "Street Style", challenge: "Authentic street style photography allows you to snag shots of the latest fashion—all without the strut of the runway. Look for colors first (either eye-catching or stunningly neutral), then watch for the cut and structure of the clothes. Aim for overall beauty within the frame, including the street or walkway, so the focus isn’t solely on the clothes.")
        
        let six = PhotoChallenge(title: "Details, Details, Details", challenge: "Create a collection of shots with unique subjects that focus on the details.")
        
        let seven = PhotoChallenge(title: "Natural Element", challenge: "Plan for your gallery of photos to include candid shots of the subject in their element. Whether they love the beach or like to craft, you can capture your subject in their favorite space or place to go.")
        
        let eight = PhotoChallenge(title: "Pet Photography", challenge: "The heart and soul of your pets can be captured with the right technique. Incorporate natural light in your shoot keep watch of your pet’s eyes. Expressions and personality often shine through and it’s a great time to capture these moments.")
        
        let nine = PhotoChallenge(title: "Motherhood", challenge: "Encapsulate the full spectrum of motherhood with photos from quiet moments like snuggling with your child to lively times like cooking together in the kitchen. Make sure your images tells a story.")
        
        let ten = PhotoChallenge(title: "Panoramic Picture", challenge: "A popular technique for landscapes, panoramic photography enlarges the viewpoint beyond the normal size of a camera lens. To ensure there are no gaps in your panoramic shot, overlap your image by 15-30%. Don’t forget that panos work well for vertical shots, too, like waterfalls and deep canyons.")
        
        let eleven = PhotoChallenge(title: "Sunset", challenge: "For maximum beauty, be sure to slightly underexpose the sunset for rich and dramatic colors. Make your sunset even more magnificent by arranging an object or scene in the foreground of the sunset, like a lake or mountain.")
        
        let twelve = PhotoChallenge(title: "Fog", challenge: "Mist and fog are natural elements that can enhance the beauty of your photography. Check the weather to determine when fog might pop up.")
        
        let thirteen = PhotoChallenge(title: "Cityscapes: Day", challenge: "Hovering skyscrapers and diverse skylines are part of what makes cityscapes such attractive photography. For a cityscapes project, try different vantage points across the city to see what works best (think: a popular lookout compared with a more secret locale).")
        
        let fourteen = PhotoChallenge(title: "Cityscapes: Night", challenge: "For a cityscapes project, try different vantage points across the city to see what works best. Prepare for an after sunset shoot, allowing the city lights to pop against the dark sky. Remember to use a wide angle lens to cover as much ground as possible.")
        
        let fifteen = PhotoChallenge(title: "Water: Rain or Oceans", challenge: "Pack along a lens-friendly cloth to remove splashes and water marks. Plan to get wet if you’re banking on a stunning water shot.")
        
        let sixteen = PhotoChallenge(title: "Seasons", challenge: "Each season offers its own charms—from snowy branches to colored leaves. Select a location for your seasons challenge and capture the beauty of the season. ")
        
        let seventeen = PhotoChallenge(title: "Star Trails", challenge: "Find a clear sky full of stars, but free of pollution and other light interference. Anchoring your camera on a tripod, set your camera to shoot on manual mode. The faster the lens you have, the better.")
        
        let eighteen = PhotoChallenge(title: "Drone", challenge: "Capturing still images with a remote-controlled drone opens up the options for angles and perspectives in your photography. Consider sending a drone above a beach, golf course or mountaintop.")
        
        let nineteen = PhotoChallenge(title: "Food", challenge: "As a still life technique, food photography requires a few main ingredients: good lighting, props and style. Amplify the photo’s texture with decorative pieces like colorful fruits and sprigs of herbs.")
        
        let twenty = PhotoChallenge(title: "Black and White", challenge: "Two-toned photography provides a different perspective or feel to your work, and gives you a chance to highlight people, places and objects in a novel way.")
        
        let twentyone = PhotoChallenge(title: "Random Acts of Kindness", challenge: "Capture someone doing something thoughtful or helpful for another person. By photographing these moments, you’re telling a larger story of humanity.")
        
        let twentytwo = PhotoChallenge(title: "Shoes For A Week", challenge: "Narrow your photography focus for a week by capturing different styles of footwear. From boots to sandals to athletic shoes, diversify your image collection. Be sure to utilize a range of angles to create unique stories for each photo.")
        
        let twentythree = PhotoChallenge(title: "Comfort Zone", challenge: "Pushing the limits of your creativity often leaves you with impressive and surprising results. With the comfort zone challenge, throw caution to the wind and experiment without expectations.")
        
        let twentyfour = PhotoChallenge(title: "20 Strangers", challenge: "Taking a photo of someone whom you’ve only just met can be thrilling. It can also be personally and professionally rewarding. Capture 20 portraits of people you’ve never met before. Be sure to ask each person’s consent first before posting publicly.")
    
        let twentyfive = PhotoChallenge(title: "Coffee", challenge: "Collaborate with a barista on a latte design or the type of mug to use. Choose a simple backdrop so the coffee remains the focal point.")
        
        let twentysix = PhotoChallenge(title: "Photo Album", challenge: "Create a photo album. Design your photo album with a theme in mind to build cohesion. Vary your layouts from page to page for texture and personality.")
        
        let twentyseven = PhotoChallenge(title: "Happy", challenge: "Allow joy to take the center stage of your photos. Whether they’re candid shots of family members interacting or a single subject, make sure the smiles are natural.")
        
        let twentyeight = PhotoChallenge(title: "Photo Scavenger Hunt", challenge: "Challenge yourself and your fellow photographers by setting up a photo scavenger hunt. Create a list of locations, subjects, and photography styles to achieve.")
        
        let twentynine = PhotoChallenge(title: "Night Scenes", challenge: "Night scenes, also known as low light photography, allow you to make the most of dark scenes that are hard to capture.")
        
        let thirty = PhotoChallenge(title: "Letters/Signs", challenge: "With any inanimate object, the challenge with photography is to bring it to life. With letters and signs, try to enrich the shot with the surrounding scene whether it’s greenery or a neat light fixture. Angle your lens in a way that makes the lettering most striking.")
        
        let thirtyone = PhotoChallenge(title: "Action Shot", challenge: "To nail a clear action shot—for sports, animals or anything else—the most important aspect is to be prepared. Consider pre-focusing your shot, so when the subject enters the frame, you’re ready.")
        
        let thirtytwo = PhotoChallenge(title: "Abstract", challenge: "Fundamental to abstract photography are lines and curves. The shapes you highlight will guide the viewer’s eye to a certain engaging element.")
        
        let thirtythree = PhotoChallenge(title: "Single Lens", challenge: "To sharpen your skills, try using a single lense for an entire week. Ideally, the lense will be new to you—allowing you to master the new tool and broaden your photography skills.")
        
        let thirtyfour = PhotoChallenge(title: "Architecture", challenge: "Photographing architecture—whether modern or classic—presents unique challenges. Consider capturing an array of building styles for your portfolio and don’t forget to mix up your angles")
        
        let thirtyfive = PhotoChallenge(title: "Top View", challenge: "Try a series of photos where your perspective comes from the top. Amp up the creativity by getting higher for your shoot and using a wide angle lens.")
        
        let thirtysix = PhotoChallenge(title: "Silhouettes", challenge: "Forming a distinct contrast between light and dark, silhouettes highlight one or multiple subjects. Ensure your subject is backlit with the sun behind them.")
        
        let thirtyseven = PhotoChallenge(title: "Symmetry", challenge: "Finding subjects that offer you symmetry is the foundational step for this photography project idea. Look for symmetry in architecture and nature, or with human and animal subjects.")
        
        let thirtyeight = PhotoChallenge(title: "Bokeh", challenge: "Bokeh photography is denoted by one unique characteristic: a blur produced in the out-of-focus area of an image. The blur, produced by a lens, helps direct the focus of the photo.")
        
        let thirtynine = PhotoChallenge(title: "Action Figures", challenge: "Due to their size, action figures are easy to rearrange and shoot from multiple angles. Bring the scene to life by having the figures interact with each other.")
        
        let forty = PhotoChallenge(title: "Wardrobe", challenge: "On each day of the week, snap photos of your clothes before you begin the day. Arrange them differently—sometimes orderly, sometimes more carelessly—to gain a sense of how your mood changed from day to day. Remember to include accessories like purses, shoes, belts and headbands.")
        
        let fortyone = PhotoChallenge(title: "Smoke", challenge: "For this photography project, choose smoke as your primary accent.")
        
        let fortytwo = PhotoChallenge(title: "Vintage Car", challenge: "From sporty models to classic town cars, vintage vehicles never go out of style. Highlight specific parts, like bumpers, trunks and hoods for diverse perspectives.")
        
        let fortythree = PhotoChallenge(title: "Picture Frame", challenge: "Alter your perspective by shooting your subject through a picture frame.")
        
        let fortyfour = PhotoChallenge(title: "Sports Car", challenge: "Sports cars are riddled with smooth line, sharp accents, and beautiful textures. Capture the raw beauty. Use landscapes and scenery to help showcase the cars identity.")
        
        let fortyfive = PhotoChallenge(title: "Texture Overlay", challenge: "Overlay your images with textures at the post-processing stage to give your images an edge. It works best with an unusual texture, such as cracked concrete, paint dabs or even water ripples.")
        
        let fortysix = PhotoChallenge(title: "Fatherhood", challenge: "Take photos of a father interecting with their son(s), or an older gentleman assisting a young man. Capture the wisdom being shared, or the happiness each brings.")
        
        let fortyseven = PhotoChallenge(title: "Juxtaposition", challenge: "Juxtaposition is when you capture two contrasting subjects in the same frame. Which helps to highlight the differences between those subjects.")
        
        let fortyeight = PhotoChallenge(title: "Humanity", challenge: "The theme of humanity, social or economic climates, and the world we live in today is an important photographic concept. You can present subjects in ways that could potentially influence your viewer’s opinion for both good or bad. This is a powerful skill to master.")
        
        let fortynine = PhotoChallenge(title: "Double Exposure", challenge: "Double exposure is an editing technique that combines 2 different images into one. You can tell two sides of one story in a single image. The end results are beautiful and unique.")
        
        let fifty = PhotoChallenge(title: "Fashion", challenge: "Fashion photography is all about clothes and beauty, so pull all the elements of the scene and the model together to reflect this.")
        
        return [one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twentyone, twentytwo, twentythree, twentyfour, twentyfive, twentysix, twentyseven, twentyeight, twentynine, thirty, thirtyone, thirtytwo, thirtythree, thirtyfour, thirtyfive, thirtysix, thirtyseven, thirtyeight, thirtynine, forty, fortyone, fortytwo, fortythree, fortyfour, fortyfive, fortysix, fortyseven, fortyeight, fortynine, fifty]
    }

}//end of class

