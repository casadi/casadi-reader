function value = read(path)
%READ Decode a Function.save() file to MATLAB data without loading CasADi.
    document = casadi_reader.Document(path);
    cleanup = onCleanup(@() delete(document));
    value = document.data();
end
