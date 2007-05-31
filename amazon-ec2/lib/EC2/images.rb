# Amazon Web Services EC2 Query API Ruby Library
# This library has been packaged as a Ruby Gem 
# by Glenn Rempe ( grempe @nospam@ rubyforge.org ).
# 
# Source code and gem hosted on RubyForge
# under the Ruby License as of 12/14/2006:
# http://amazon-ec2.rubyforge.org

module EC2
  
  class AWSAuthConnection
    
    # The RegisterImage operation registers an AMI with Amazon EC2. 
    # Images must be registered before they can be launched.  Each 
    # AMI is associated with an unique ID which is provided by the 
    # EC2 service via the Registerimage operation. As part of the 
    # registration process, Amazon EC2 will retrieve the specified 
    # image manifest from Amazon S3 and verify that the image is 
    # owned by the user requesting image registration.  The image 
    # manifest is retrieved once and stored within the Amazon EC2 
    # network. Any modifications to an image in Amazon S3 invalidate 
    # this registration. If you do have to make changes and upload 
    # a new image deregister the previous image and register the new image.
    def register_image(imageLocation)
      params = { "ImageLocation" => imageLocation }
      RegisterImageResponse.new(make_request("RegisterImage", params))
    end
    
    # The DescribeImages operation returns information about AMIs available 
    # for use by the user. This includes both public AMIs (those available 
    # for any user to launch) and private AMIs (those owned by the user 
    # making the request and those owned by other users that the user 
    # making the request has explicit launch permissions for).
    #
    # The list of AMIs returned can be modified via optional lists of AMI IDs, 
    # owners or users with launch permissions. If all three optional lists 
    # are empty all AMIs the user has launch permissions for are returned. 
    # Launch permissions fall into three categories:
    #
    # Launch Permission	Description
    #  * public	The all group has launch permissions for the AMI. All users have 
    #    launch permissions for these AMIs.
    #  * explicit	The owner of the AMIs has granted a specific user launch permissions for the AMI.
    #  * implicit	A user has implicit launch permissions for all AMIs he or she owns.
    #
    # If one or more of the lists are specified the result set is the intersection 
    # of AMIs matching the criteria of the individual lists.
    #
    # Providing the list of AMI IDs requests information for those AMIs only. 
    # If no AMI IDs are provided, information of all relevant AMIs will be 
    # returned. If an AMI is specified that does not exist a fault is returned. 
    # If an AMI is specified that exists but the user making the request does 
    # not have launch permissions for, then that AMI will not be included in 
    # the returned results.
    #
    # Providing the list of owners requests information for AMIs owned 
    # by the specified owners only. Only AMIs the user has launch permissions 
    # for are returned. The items of the list may be account ids for AMIs 
    # owned by users with those account ids, amazon for AMIs owned by Amazon 
    # or self for AMIs owned by the user making the request.
    # 
    # The executable list may be provided to request information for AMIs 
    # that only the specified users have launch permissions for. The items of 
    # the list may be account ids for AMIs owned by the user making the request 
    # that the users with the specified account ids have explicit launch permissions 
    # for, self for AMIs the user making the request has explicit launch permissions 
    # for or all for public AMIs.
    #
    # Deregistered images will be included in the returned results for an 
    # unspecified interval subsequent to deregistration.
    def describe_images(imageIds=[], owners=[], executableBy=[])
      params = pathlist("ImageId", imageIds)
      params.merge!(pathlist("Owner", owners))
      params.merge!(pathlist("ExecutableBy", executableBy))
      DescribeImagesResponse.new(make_request("DescribeImages", params))
    end
    
    # The DeregisterImage operation deregisters an AMI. Once deregistered, 
    # instances of the AMI may no longer be launched.
    def deregister_image(imageId)
      params = { "ImageId" => imageId }
      DeregisterImageResponse.new(make_request("DeregisterImage", params))
    end
    
  end
  
end
