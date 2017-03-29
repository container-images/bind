$TTL 3h
@ SOA ${mname} ${rname} ${serial} ${refresh} ${retry} ${expire} ${minimum}
% for nameserver in nameservers:
  NS ${nameserver}
% endfor
% for name, data in sorted(records.items()):
    % for typ, values in sorted(data.items()):
        % for value in sorted(values):
${name} ${typ} ${value}
	% endfor
    % endfor
% endfor
