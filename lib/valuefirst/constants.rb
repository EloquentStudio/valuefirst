module Valuefirst
  module Constants
    
    VALID_ACTIONS = %w(send status credits)

    ERROR_CODES = {
        '52992'=> 'Username / Password incorrect',
        '57089'=> 'Contract expired',
        '57090'=> 'User Credit expired',
        '57091'=> 'User disabled',
        '65380'=> 'Service is temporarily unavailable',
        '65535'=> 'The specified message does not conform to DTD',
        '28673'=> 'Destination number not numeric',
        '28674'=> 'Destination number empty',
        '28675'=> 'Sender address empty',
        '28676'=> 'SMS over 160 character, Non-compliant message',
        '28677'=> 'UDH is invalid',
        '28678'=> 'Coding is invalid',
        '28679'=> 'SMS text is empty',
        '28680'=> 'Invalid sender ID',
        '28681'=> 'Invalid message, Duplicate message, Submit failed',
        '28682'=> 'Invalid Receiver ID',
        '28683'=> 'Invalid Date time for message Schedule',
        '8448'=> 'Message delivered successfully',
        '8449'=> 'Message failed',
        '8450'=> 'Message ID is invalid',
        '13568'=> 'Command Completed Successfully',
        '13569'=> 'Cannot update/delete schedule since it has already been processed',
        '13570'=> 'Cannot update schedule since the new date-time parameter is incorrect',
        '13571'=> 'Invalid SMS ID/GUID',
        '13572'=> 'Invalid Status type for schedule search query. The status strings can be PROCESSED, PENDING and ERROR',
        '13573'=> 'Invalid date time parameter for schedule search query',
        '13574'=> 'Invalid GUID for GUID search query',
        '13575'=> 'Invalid command action'
    }
  end
end