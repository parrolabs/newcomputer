#!/bin/bash



function Install_Xcode {
  if xcode-select -p
   then
  echo "Xcode Is already Installed"  
   else
  xcode-select --install
  fi
}


function Install_Homebrew {

if brew -v
then
  echo "Homebrew Is already Installed"
else
  if find /opt/homebrew/Cellar/  -maxdepth 1 -type d -exec basename {} \;
  then
    echo "Homebrew Installed But Not Added to the Path"
    echo "To uninstall Homebrew and Start over run..."
   else
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc
 fi
fi


}


function Uninstall_Homebrew {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
  
}


function Install_Apps {
    if dockutil -h
    then
      echo "Dockutil is already installed"
    else
     brew install dockutil
    echo "Just installed Dockutil"

    fi

    # Removing All Dock Items Using Dockutil
   
    echo "Let's Install Some Apps.."



    echo "let's Start by Installing Slack"

    brew list slack || brew install --cask slack

    

    echo "Slack is Installed"



    echo "Installing Google Chrome"

    brew list google-chrome || brew install --cask google-chrome

    

    echo "Google Chrome is Installed"


    echo "Installing Firefox"

    brew list firefox || brew install --cask firefox

    
    echo "Firefox is Installed"


    echo "Installing Clickup"

    brew list clickup || brew install --cask clickup

    

    echo "Clickup is Installed"


    echo "Installing Clockify"

    brew list clockify || brew install --cask clockify


    

    # Reset the Dock and Add only the apps
    dockutil --remove all
    dockutil --add "/Applications/Slack.app"
    dockutil --add "/Applications/Google Chrome.app"
    dockutil --add "/Applications/Firefox.app"
    dockutil --add "/Applications/ClickUp.app"
    dockutil --add "/Applications/Clockify Desktop.app"

  
}

function developer_tools {
   echo "Installing Github Command Line Tools"

    brew list gh || brew install gh
   echo "Installing V-studio Code"
    brew list visual-studio-code || brew install --cask visual-studio-code
   dockutil --add "/Applications/Visual Studio Code.app"
   echo "Installing Postman"
    brew list postman || brew install --cask postman
   dockutil --add "/Applications/Postman.app"

   brew list docker || brew install --cask docker
   
  
  

}



function set_wallpaper {

   brew list wallpaper || brew install wallpaper
   brew list wget || brew install wget
   wget -O /tmp/Wallpaper.jpg https://assets.parrolabs.com/wallpapers/03%20wallpaper%20parrolabs%201920x1080.jpeg
   wallpaper set /tmp/Wallpaper.jpg
}








function User_Input {
  echo "What would you like to do?"
  echo "1. Install X-Code and Homebrew (required for App install)"
  echo "2. Uninstall Homebrew"
  echo "3. Install General Apps (Google Chrome, Firefox, Clockify, Clickup, Slack)"
  echo "4. Install General Developer Apps"
  echo "5. Install Designer Apps"
  echo "6. See which apps are installed"
  echo "7. Set Wallpaper to Parrolabs"
  echo "Choose 1-6 or 9 to close"
  read UserAnswer

  echo "You replied $UserAnswer"

  if [[ "$UserAnswer" -eq 1 ]]; then
    Install_Xcode
    Install_Homebrew
    User_Input
  elif [[ "$UserAnswer" -eq 2 ]]; then
    Uninstall_Homebrew
  elif [[ "$UserAnswer" -eq 3 ]]; then
    Install_Apps
  elif [[ "$UserAnswer" -eq 4 ]]; then
    developer_tools
  elif [[ "$UserAnswer" -eq 6 ]]; then
    brew list || echo "brew not installed"
  elif [[ "$UserAnswer" -eq 7 ]]; then
    set_wallpaper
  elif [[ "$UserAnswer" -eq 9 ]]; then
    exit
  else
   echo "Not a Valid Input...answer 1-6 or 9 to close"
   User_Input
  fi
}

User_Input